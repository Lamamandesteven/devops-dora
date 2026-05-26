# devops-dora

Projet TP DevOps & DORA

## Contenu
- API Flask avec les routes `/` et `/health`
- Tests automatisés avec pytest
- Contrôle qualité avec flake8
- Conteneurisation avec Docker
- Pipeline CI/CD avec GitHub Actions

## Lancement local
source .venv/bin/activate
python app.py

## Tests
pytest -q

## Lint
flake8 app.py

## Docker
docker build -t mastere-devops .
docker run -d -p 5000:5000 --name mastere-devops mastere-devops
