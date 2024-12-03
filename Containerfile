FROM docker.io/archlinux:latest

# Sync databases, get packages
RUN pacman -Sy; pacman -S archiso --noconfirm

COPY ./archiso-profile /profile
COPY ./container-entrypoint /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
