import pymongo
from config import MONGO_URI, DB_NAME

class MongoDB:
    def __init__(self):
        try:
            self.client = pymongo.MongoClient(MONGO_URI)
            self.db = self.client[DB_NAME]
            print("Conexão com o MongoDB estabelecida com sucesso!")
        except pymongo.errors.ConnectionFailure as e:
            print(f"Não foi possível conectar ao MongoDB: {e}")
            self.client = None
            self.db = None

    def get_db(self):
        return self.db

mongo_db = MongoDB()

def get_mongo_connection():
    """Função helper para obter a instância do banco de dados."""
    db_instance = mongo_db.get_db()
    if db_instance is None:
        raise ConnectionError("A conexão com o MongoDB não está disponível.")
    return db_instance