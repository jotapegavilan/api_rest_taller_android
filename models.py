from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

class usuarios(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=True)
    nombres = db.Column(db.Text, nullable=False, unique=True)
    apellidos = db.Column(db.Text, nullable=False)
    email = db.Column(db.Text, nullable=False)
    clave = db.Column(db.Text, nullable=False)
    rol = db.Column(db.Text, nullable=True)    
    projects = db.relationship('proyectos', backref='usuario')

    def getClave(self):
        return self.clave.encode('utf-8')

    def serialize(self):
        return {
            "id" : self.id,
            "nombres" : self.nombres,            
            "apellidos" : self.apellidos,
            "email" : self.email,
            "rol" : self.rol
        }

class proyectos(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=True)
    nombre = db.Column(db.Text, nullable=False, unique=True)
    descripcion = db.Column(db.Text, nullable=False)    
    repositorio = db.Column(db.Text, nullable=False)    
    fecha_creacion = db.Column(db.DateTime,nullable=True)
    fecha_fin = db.Column(db.DateTime,nullable=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'))
    categoria_id = db.Column(db.Integer, db.ForeignKey('categorias.id'))
    lenguaje_id = db.Column(db.Integer, db.ForeignKey('lenguajes.id'))

    def serialize(self):
        return {
            "id" : self.id,
            "nombre" : self.nombre,            
            "descripcion" : self.descripcion,
            "repositorio" : self.repositorio,
            "fecha_creacion" : self.fecha_creacion,
            "fecha_fin" : self.fecha_fin,
            "usuario_id" : self.usuario_id,
            "categoria_id" : self.categoria_id,
            "lenguaje_id" : self.lenguaje_id,
            "categoria" : categorias.query.filter_by(id=self.categoria_id).first().serialize(),
            "usuario" : usuarios.query.filter_by(id=self.usuario_id).first().serialize(),
            "lenguaje" : lenguajes.query.filter_by(id=self.lenguaje_id).first().serialize()
        }


class categorias(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=True)
    nombre = db.Column(db.Text, nullable=False, unique=True)
    color = db.Column(db.Text, nullable=False)
    projects = db.relationship('proyectos', backref='categoria')
      
    def serialize(self):
        return {
            "id" : self.id,
            "nombre" : self.nombre,            
            "color" : self.color            
        }

class lenguajes(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=True)
    nombre = db.Column(db.Text, nullable=False, unique=True)
    img = db.Column(db.Integer, nullable=False)    
      
    def serialize(self):
        return {
            "id" : self.id,
            "nombre" : self.nombre,            
            "img" : self.img            
        }