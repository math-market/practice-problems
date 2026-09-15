# Sandbox image for the practice-problem checkers. Read it in ten seconds.
# Base pinned by digest so the environment is fixed by this commit.
# The board selects its checker: docker run IMAGE golomb8 /sub.json
FROM python:3.12-slim@sha256:57cd7c3a7a273101a6485ba99423ee568157882804b1124b4dd04266317710de
WORKDIR /task
COPY boards.tsv /task/boards.tsv
COPY run.sh /task/run.sh
COPY */check.py /task/checkers/
USER 65534:65534
ENTRYPOINT ["/bin/sh", "/task/run.sh"]
