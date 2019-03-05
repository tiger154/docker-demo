FROM mariadb:10.0.33
MAINTAINER "Jeonhwan <demoprogrammer@gmail.com>"
ENV TZ Asia/Seoul

RUN apt-get update && apt-get install -y vim

CMD ["--character-set-client-handshake=FALSE", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_bin","--group-concat-max-len=10000000"]
