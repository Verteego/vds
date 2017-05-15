FROM jupyter/datascience-notebook

ENV JUPYTER_PORT "33335"

COPY templates/jupyter_notebook_config.py.j2 /home/jovyan/.jupyter/jupyter_notebook_config.py
RUN sed -i s/PORT/${JUPYTER_PORT}/ /home/jovyan/.jupyter/jupyter_notebook_config.py

EXPOSE $JUPYTER_PORT
ENTRYPOINT ["start-notebook.sh"]