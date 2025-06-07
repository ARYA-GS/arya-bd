from flask import Flask, render_template, request, redirect, url_for
from db import desastres_collection, relatorios_collection
from bson import ObjectId
from datetime import datetime

app = Flask(__name__)

# Função auxiliar para pegar a collection
def get_collection(name):
    if name == "desastres_naturais":
        return desastres_collection
    elif name == "relatorios_desastres":
        return relatorios_collection
    return None

# Página inicial
@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        collection = request.form["collection"]
        operacao = request.form["operacao"]
        return redirect(url_for(operacao, collection=collection))
    return render_template("index.html")

# Criar documento
@app.route("/criar/<collection>", methods=["GET", "POST"])
def criar(collection):
    col = get_collection(collection)
    if request.method == "POST":
        data = request.form.to_dict()
        if "data" in data:
            try:
                data["data"] = datetime.strptime(data["data"], "%Y-%m-%d")
            except:
                pass
        col.insert_one(data)
        return redirect(url_for("index"))
    return render_template("form_criar.html", collection=collection)

# Listar documentos
@app.route("/listar/<collection>")
def listar(collection):
    col = get_collection(collection)
    documentos = list(col.find())
    return render_template("listar.html", collection=collection, documentos=documentos)

# Editar (requer ID)
@app.route("/editar/<collection>", methods=["GET", "POST"])
def editar(collection):
    col = get_collection(collection)
    if request.method == "POST":
        id_doc = request.form["id"]
        campo = request.form["campo"]
        valor = request.form["valor"]
        col.update_one({"_id": ObjectId(id_doc)}, {"$set": {campo: valor}})
        return redirect(url_for("listar", collection=collection))
    return render_template("editar.html", collection=collection)

# Deletar (requer ID)
@app.route("/deletar/<collection>", methods=["GET", "POST"])
def deletar(collection):
    col = get_collection(collection)
    if request.method == "POST":
        id_doc = request.form["id"]
        col.delete_one({"_id": ObjectId(id_doc)})
        return redirect(url_for("listar", collection=collection))
    return render_template("deletar.html", collection=collection)

if __name__ == "__main__":
    app.run(debug=True)
