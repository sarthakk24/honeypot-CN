FROM python:3.8


# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV POETRY_HOME="/opt/poetry"
ENV VENV_PATH="/opt/pysetup/.venv"
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"
RUN echo $PATH
# install package manager
RUN curl -sSL https://install.python-poetry.org | python3 -

# copy all files to the working directory
WORKDIR /usr/src/ssh-honeypot
COPY . .

# install packages through poetry
RUN poetry config virtualenvs.create false && poetry install 

# start the SSH honeypot server
EXPOSE 2222
CMD ["poetry", "run", "python", "honeypot.py"]