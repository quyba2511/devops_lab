#!/bin/bash
DISK_LIMIT=80
SERVICES=("nginx" "ssh")

check_disk() {
    DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
    if [ $DISK -gt $DISK_LIMIT ]; then
        echo "CANH BAO: Disk dang dung ${DISK}% -- vuot nguong ${DISK_LIMIT}%"
    else
        echo "OK: Disk ${DISK}% -- con an toan"
    fi
}

check_services() {
    for SERVICE in "${SERVICES[@]}"; do
        STATUS=$(systemctl is-active $SERVICE)
        if [ "$STATUS" == "active" ]; then
            echo "OK: $SERVICE dang chay"
        else
            echo "CANH BAO: $SERVICE KHONG chay"
        fi
    done
}

echo "=== Health Check: $(date) ==="
check_disk
check_services
echo "=== Done ==="
