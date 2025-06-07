from pymongo import MongoClient
from config import MONGO_URI, MONGO_DB_NAME

client = MongoClient(MONGO_URI)

db = client[MONGO_DB_NAME]

desastres_collection = db["desastres_naturais"]
relatorios_collection = db["relatorios_desastres"]

def get_db():
    return db

def get_collections_list():
    return db.list_collection_names()