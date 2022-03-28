#!/bin/sh

totalbytes() {
  case "$1" in
    RX)
      printf '%d\n' \
        "$(($(ip -s -o link | grep -oP -A1 'RX:[[:alpha:]\s\\]*\d+' | \
        grep -oP '\d+' | tr '\n' '+' | sed 's/\+$//')))" ;;
    TX)
      printf '%d\n' \
        "$(($(ip -s -o link | grep -oP -A1 'TX:[[:alpha:]\s\\]*\d+' | \
        grep -oP '\d+' | tr '\n' '+' | sed 's/\+$//')))" ;;
    *)
      printf '0\n' ;;
  esac
}

case "$1" in
  mem)
    free -h | awk '/^Mem/ { print $3"/"$2 }' | sed s/i//g
    ;;
  cpu)
    top -n 1 | awk '/^%Cpu/ { print $2 "%" }'
    ;;
  net)
    ra=$(totalbytes "RX"); ta=$(totalbytes "TX")
    sleep 0.5
    rb=$(totalbytes "RX"); tb=$(totalbytes "TX")
    printf '↓%s/s ↑%s/s\n' \
      "$(numfmt --to=iec-i --suffix=B $(($((rb-ra))*2)))" \
      "$(numfmt --to=iec-i --suffix=B $(($((tb-ta))*2)))"
    ;;
  *)
    printf '\n'
    ;;
esac

