# app.py

import csv
import io
from flask import Flask, request, jsonify, render_template, Response
from bson import ObjectId
from bson.errors import InvalidId

# Importa a função de conexão do nosso módulo db
from db import get_mongo_connection

app = Flask(__name__)

# Dicionário para tradução dos campos, conforme solicitado.
TRADUCOES = {
    'Nome atual': 'Nome mais bonito',
    'id_zona': 'id_zona',
    'regiao': 'regiao',
    'latitude': 'latitude',
    'longitude': 'longitude',
    'data': 'data',
    'estacao': 'estacao_do_ano',
    'chuva': 'precipitacao_mm',
    'temperatura': 'temperatura_c',
    'umidade': 'umidade_percentual',
    'densidade': 'densidade_populacional',
    'altitude': 'altitude_metros',
    'declive': 'declividade_graus',
    'dist_agua': 'distancia_agua_km',
    'tipo_solo': 'tipo_de_solo',
    'uso': 'uso_do_solo',
    'accesibilidad': 'nivel_acessibilidade',
    'sismo': 'frequencia_sismos',
    'tipo': 'tipo_evento',
    'risco': 'nivel_de_risco',
    'ocorrencia': 'ocorreu'
}

def traduzir_campo(campo_tecnico):
    """Traduz um nome de campo técnico para um nome amigável."""
    return TRADUCOES.get(campo_tecnico, campo_tecnico)

# Rota principal que renderiza o frontend
@app.route('/')
def index():
    """Renderiza a página HTML principal."""
    return render_template('index.html')

# --- ROTAS DA API ---

@app.route('/api/collections', methods=['GET'])
def get_collections():
    """Lista todas as coleções no banco de dados."""
    try:
        db = get_mongo_connection()
        collections = db.list_collection_names()
        # Remove coleções do sistema, se houver
        collections = [c for c in collections if not c.startswith('system.')]
        return jsonify(collections)
    except Exception as e:
        return jsonify({"erro": f"Erro ao buscar coleções: {str(e)}"}), 500

@app.route('/api/data/<collection_name>', methods=['GET'])
def get_all_docs(collection_name):
    """Lista todos os documentos de uma coleção."""
    try:
        db = get_mongo_connection()
        collection = db[collection_name]
        
        docs = list(collection.find({}))
        # Converte ObjectId para string para ser serializável em JSON
        for doc in docs:
            doc['_id'] = str(doc['_id'])
            
        return jsonify(docs)
    except Exception as e:
        return jsonify({"erro": f"Erro ao buscar documentos: {str(e)}"}), 500

@app.route('/api/data/<collection_name>', methods=['POST'])
def create_doc(collection_name):
    """Cria um novo documento em uma coleção."""
    try:
        db = get_mongo_connection()
        collection = db[collection_name]
        data = request.json
        
        # Remove o campo _id se ele foi enviado vazio no formulário
        if '_id' in data and not data['_id']:
            del data['_id']

        result = collection.insert_one(data)
        return jsonify({"sucesso": True, "id_inserido": str(result.inserted_id)}), 201
    except Exception as e:
        return jsonify({"erro": f"Erro ao criar documento: {str(e)}"}), 500

@app.route('/api/data/<collection_name>/<doc_id>', methods=['PUT'])
def update_doc(collection_name, doc_id):
    """Atualiza um documento existente."""
    try:
        db = get_mongo_connection()
        collection = db[collection_name]
        data = request.json
        
        # O _id não deve ser atualizado, então o removemos do payload
        if '_id' in data:
            del data['_id']
            
        result = collection.update_one({'_id': ObjectId(doc_id)}, {'$set': data})
        if result.matched_count == 0:
            return jsonify({"erro": "Documento não encontrado"}), 404
            
        return jsonify({"sucesso": True, "modificados": result.modified_count})
    except InvalidId:
        return jsonify({"erro": "ID inválido"}), 400
    except Exception as e:
        return jsonify({"erro": f"Erro ao atualizar documento: {str(e)}"}), 500

@app.route('/api/data/<collection_name>/<doc_id>', methods=['DELETE'])
def delete_doc(collection_name, doc_id):
    """Deleta um documento."""
    try:
        db = get_mongo_connection()
        collection = db[collection_name]
        result = collection.delete_one({'_id': ObjectId(doc_id)})
        
        if result.deleted_count == 0:
            return jsonify({"erro": "Documento não encontrado"}), 404
            
        return jsonify({"sucesso": True, "deletados": result.deleted_count})
    except InvalidId:
        return jsonify({"erro": "ID inválido"}), 400
    except Exception as e:
        return jsonify({"erro": f"Erro ao deletar documento: {str(e)}"}), 500

@app.route('/api/export/<collection_name>', methods=['GET'])
def export_data(collection_name):
    """Exporta dados de uma coleção para JSON ou CSV."""
    format_type = request.args.get('format', 'json').lower()
    
    try:
        db = get_mongo_connection()
        collection = db[collection_name]
        data = list(collection.find({}))

        if not data:
            return jsonify({"erro": "Nenhum dado para exportar"}), 404

        # Remove o ObjectId para a exportação
        for item in data:
            item['_id'] = str(item['_id'])

        if format_type == 'json':
            return Response(
                str(data),
                mimetype="application/json",
                headers={"Content-disposition": f"attachment; filename={collection_name}.json"}
            )
        elif format_type == 'csv':
            output = io.StringIO()
            writer = csv.writer(output)
            
            # Escreve o cabeçalho (traduzido)
            headers = data[0].keys()
            translated_headers = [traduzir_campo(h) for h in headers]
            writer.writerow(translated_headers)
            
            # Escreve os dados
            for row in data:
                writer.writerow(row.values())
                
            return Response(
                output.getvalue(),
                mimetype="text/csv",
                headers={"Content-disposition": f"attachment; filename={collection_name}.csv"}
            )
        else:
            return jsonify({"erro": "Formato de exportação inválido. Use 'json' ou 'csv'."}), 400

    except Exception as e:
        return jsonify({"erro": f"Erro ao exportar dados: {str(e)}"}), 500


if __name__ == '__main__':
    app.run(debug=True, port=5001)