#!/usr/bin/env bash
set -e

cd /root/devops-dora

case "${1:-}" in
  init)
    python3 -m venv .venv
    . .venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
    ;;
  lint)
    . .venv/bin/activate
    flake8 app.py
    ;;
  test)
    . .venv/bin/activate
    pytest -q
    ;;
  build)
    docker build -t mastere-devops .
    ;;
  run)
    docker rm -f mastere-devops 2>/dev/null || true
    docker run -d -p 5000:5000 --name mastere-devops mastere-devops
    ;;
  check)
    curl -s http://127.0.0.1:5000
    echo
    curl -s http://127.0.0.1:5000/health
    echo
    ;;
  stop)
    docker rm -f mastere-devops 2>/dev/null || true
    ;;
  all)
    . .venv/bin/activate
    flake8 app.py
    pytest -q
    docker build -t mastere-devops .
    docker rm -f mastere-devops 2>/dev/null || true
    docker run -d -p 5000:5000 --name mastere-devops mastere-devops
    sleep 2
    curl -s http://127.0.0.1:5000
    echo
    curl -s http://127.0.0.1:5000/health
    echo
    ;;
  *)
    echo "Usage: ./devops.sh {init|lint|test|build|run|check|stop|all}"
    ;;
esac
