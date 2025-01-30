import firebase_admin
from firebase_admin import credentials, firestore, storage

cred = credentials.Certificate('firebase_credentials.json')
firebase_admin.initialize_app(cred, {
    'storageBucket': 'camara-comercio-loja.appspot.com'
})

db = firestore.client()
bucket = storage.bucket()
