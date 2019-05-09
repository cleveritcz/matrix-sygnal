FROM python:2.7-slim

WORKDIR /app
ADD sygnal/. /app
ADD gunicorn_config.py /app/gunicorn_config.py

RUN pip install --trusted-host pypi.python.org gunicorn
#RUN apt update && apt -y install file gcc libc6-dev

RUN python setup.py install || pip install gevent==1.4.0 requests==2.21 && python setup.py install

EXPOSE 5000

# mount /app/sygnal.conf (and optionally override /app/gunicorn_config.py)
# also mount a log folder (for example, /log)
CMD ["gunicorn", "-c", "gunicorn_config.py", "sygnal:app"]

