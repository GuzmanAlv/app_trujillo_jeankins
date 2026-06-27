import json
import sys
from pathlib import Path

RUTA = Path('assets/data/eventos.json')
CATEGORIAS = {'cultural', 'turistico', 'danza', 'musica', 'teatro', 'gastronomia', 'deportivo', 'arte', 'taller'}
TIPOS = {'municipal', 'tradicional', 'artistico', 'recurrente', 'especial'}
CAMPOS_OBLIGATORIOS = {'id', 'titulo', 'lugar', 'fecha', 'categoria', 'esGratuito', 'precio', 'tipo'}

try:
    eventos = json.loads(RUTA.read_text(encoding='utf-8'))
except FileNotFoundError:
    print(f'ERROR: No existe {RUTA}')
    sys.exit(1)
except json.JSONDecodeError as e:
    print(f'ERROR: JSON inválido en {RUTA}: {e}')
    sys.exit(1)

if not isinstance(eventos, list):
    print('ERROR: eventos.json debe contener una lista []')
    sys.exit(1)

ids = set()
for i, evento in enumerate(eventos, start=1):
    if not isinstance(evento, dict):
        print(f'ERROR: El elemento {i} debe ser un objeto JSON')
        sys.exit(1)

    faltantes = CAMPOS_OBLIGATORIOS - evento.keys()
    if faltantes:
        print(f'ERROR: Evento {i} no tiene campos: {sorted(faltantes)}')
        sys.exit(1)

    if evento['id'] in ids:
        print(f'ERROR: ID duplicado: {evento["id"]}')
        sys.exit(1)
    ids.add(evento['id'])

    if not str(evento['titulo']).strip():
        print(f'ERROR: Evento {i} tiene título vacío')
        sys.exit(1)

    if evento['categoria'] not in CATEGORIAS:
        print(f'ERROR: Categoría inválida en evento {i}: {evento["categoria"]}')
        sys.exit(1)

    if evento['tipo'] not in TIPOS:
        print(f'ERROR: Tipo inválido en evento {i}: {evento["tipo"]}')
        sys.exit(1)

print(f'OK: {len(eventos)} eventos validados correctamente.')
