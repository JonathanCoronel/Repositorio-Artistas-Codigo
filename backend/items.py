from datetime import timezone, datetime
from flask import Flask, request, jsonify
from flask_cors import CORS
from firebaseconfig import db, bucket
from firebase_admin import firestore
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
cors = CORS(app, origins='*')

@app.route('/api/register_item', methods=['POST'])
def register_item():
    try:
        author = request.form.get('author')
        category = request.form.get('category')
        description = request.form.get('description')
        price = float(request.form.get('price', 0.0))
        title = request.form.get('title')
        date = request.form.get('fecha')
        image = request.files.get('image')

        if not image:
            return jsonify({'error': 'No se envió ninguna imagen'}), 400

        filename = secure_filename(image.filename)
        blob = bucket.blob(f"items/{filename}")
        blob.upload_from_file(image.stream, content_type=image.content_type)

        blob.make_public()
        image_url = blob.public_url

        items_ref = db.collection('items')
        new_item = {
            'author': author,
            'category': category,
            'description': description,
            'price': price,
            'date': date,
            'title': title,
            'url': image_url
        }

        doc_ref = items_ref.add(new_item)[1]

        doc_id = doc_ref.id

        items_ref.document(doc_id).update({'id': doc_id})

        return jsonify({'message': 'Item registrado exitosamente', 'image_url': image_url}), 201

    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': str(e)}), 500


@app.route('/api/get_items', methods=['GET'])
def get_items():
    try:
        items_ref = db.collection('items')
        items = [doc.to_dict() for doc in items_ref.stream()]
        return jsonify(items), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/get_category_items', methods=['GET'])
def get_category_items():
    try:
        category = request.args.get('category', '')
        if not category:
            return jsonify({'error': 'Category is required'}), 400
        
        items_ref = db.collection('items').where('category', '==', category)
        items = [doc.to_dict() for doc in items_ref.stream()]
        return jsonify(items), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/add_comment', methods=['POST'])
def add_comment():
    try:
        data = request.json
        print(f"Datos recibidos: {data}")
        item_id = request.json.get('item_id')
        user_name = request.json.get('user_name')
        comment_text = request.json.get('comment')

        if not item_id or not user_name or not comment_text:
            return jsonify({'error': 'Faltan datos'}), 400

        comment_data = {
            'user_name': user_name,
            'comment': comment_text,
            'date': datetime.now(timezone.utc).isoformat()
        }

        item_ref = db.collection('items').document(item_id)
        item = item_ref.get()
        
        if not item.exists:
            return jsonify({'error': 'Item no encontrado'}), 404

        item_ref.update({
            'comments': firestore.ArrayUnion([comment_data])
        })

        return jsonify({'message': 'Comentario agregado correctamente'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/get_comments', methods=['GET'])
def get_comments():
    try:
        item_id = request.args.get('item_id')

        if not item_id:
            return jsonify({'error': 'Se requiere item_id'}), 400

        item_ref = db.collection('items').document(item_id)
        item = item_ref.get()

        if not item.exists:
            return jsonify({'error': 'Item no encontrado'}), 404

        comments = item.to_dict().get('comments', [])

        return jsonify(comments), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/get_author_items', methods=['GET'])
def get_author_items():
    try:
        author = request.args.get('author', '')
        if not author:
            return jsonify({'error': 'Author is required'}), 400
        
        items_ref = db.collection('items').where('author', '==', author)
        items = [doc.to_dict() for doc in items_ref.stream()]
        return jsonify(items), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/toggle_like', methods=['POST'])
def toggle_like():
    try:
        data = request.json
        item_id = data.get('item_id')
        is_liked = data.get('is_liked')

        if not item_id or is_liked is None:
            return jsonify({'error': 'Faltan datos'}), 400

        item_ref = db.collection('items').document(item_id)
        item = item_ref.get()

        if not item.exists:
            return jsonify({'error': 'Item no encontrado'}), 404

        item_ref.update({'isLiked': is_liked})

        return jsonify({'message': 'Like actualizado exitosamente'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5002)
