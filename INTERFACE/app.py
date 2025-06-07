from flask import Flask, render_template, request, jsonify, redirect, url_for, Response
from db import get_db, get_collections_list
from bson import ObjectId, json_util
import json

app = Flask(__name__)
db = get_db()

# DICIONÁRIO DE MAPEAMENTO
mapeamento_campos = {
    'id_zona': 'ID da Zona', 'regiao': 'Região', 'latitude': 'Latitude', 'longitude': 'Longitude',
    'data': 'Data', 'estacao_do_ano': 'Estação', 'precipitacao_mm': 'Precipitação (mm)',
    'temperatura_c': 'Temp. (°C)', 'umidade_percentual': 'Umidade (%)',
    'densidade_populacional': 'Dens. Pop.', 'altitude_metros': 'Altitude (m)', 'declividade_graus': 'Declive (°)',
    'distancia_agua_km': 'Dist. Água (km)', 'tipo_de_solo': 'Tipo de Solo', 'uso_do_solo': 'Uso do Solo',
    'nivel_acessibilidade': 'Acessibilidade', 'frequencia_sismos': 'Sismos', 'tipo_evento': 'Evento',
    'nivel_de_risco': 'Risco', 'ocorreu': 'Ocorreu'
}
def traduzir_campo(nome_campo):
    return mapeamento_campos.get(nome_campo, nome_campo)

# Função auxiliar para serializar ObjectID para JSON
def default(o):
    if isinstance(o, ObjectId):
        return str(o)
    return json_util.default(o)

@app.route('/')
def index():
    collections = get_collections_list()
    return render_template('index.html', collections=collections)

# --- ROTAS DA API PARA CRUD ---

@app.route('/api/data/<collection_name>')
def get_data(collection_name): # READ
    try:
        collection = db[collection_name]
        data = list(collection.find({}).limit(200)) # Aumentei o limite
        for item in data:
            item['_id'] = str(item['_id'])
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/data/<collection_name>', methods=['POST'])
def add_data(collection_name): # CREATE
    try:
        data = request.get_json()
        collection = db[collection_name]
        collection.insert_one(data)
        return jsonify({"success": True, "message": "Documento adicionado com sucesso."})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400

@app.route('/api/data/<collection_name>/<doc_id>', methods=['PUT'])
def update_data(collection_name, doc_id): # UPDATE
    try:
        data = request.get_json()
        if '_id' in data: # Remove o campo _id para evitar erros de imutabilidade
            del data['_id']
        collection = db[collection_name]
        collection.update_one({'_id': ObjectId(doc_id)}, {'$set': data})
        return jsonify({"success": True, "message": "Documento atualizado com sucesso."})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400

@app.route('/api/data/<collection_name>/<doc_id>', methods=['DELETE'])
def delete_data(collection_name, doc_id): # DELETE
    try:
        collection = db[collection_name]
        result = collection.delete_one({'_id': ObjectId(doc_id)})
        if result.deleted_count == 1:
            return jsonify({"success": True, "message": "Documento deletado com sucesso."})
        else:
            return jsonify({"success": False, "error": "Documento não encontrado."}), 404
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400

# --- NOVA ROTA DE EXPORTAÇÃO ---

@app.route('/api/export/<collection_name>')
def export_collection(collection_name):
    try:
        collection = db[collection_name]
        data_cursor = list(collection.find({}))
        
        json_data = json.dumps(data_cursor, default=default, indent=4)
        
        return Response(
            json_data,
            mimetype="application/json",
            headers={"Content-disposition":
                     f"attachment; filename={collection_name}.json"}
        )
    except Exception as e:
        return f"Ocorreu um erro ao exportar: {e}", 500

if __name__ == '__main__':
    app.run(debug=True)
