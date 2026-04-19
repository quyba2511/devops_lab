
#!/bin/bash


DISK_LIMIT=80

SERVICES=("nginx" "ssh")


check_disk() {

    DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
    if [ $DISK -gt $DISK_LIMIT ]; then

        echo "CẢNH BÁO: Disk đang dùng ${DISK}% — vượt ngưỡng ${DISK_LIMIT}%"

    else

        echo "OK: Disk ${DISK}% — còn an toàn"

    fi

}


check_services() {

    for SERVICE in "${SERVICES[@]}"; do

        STATUS=$(systemctl is-active $SERVICE)

        if [ "$STATUS" == "active" ]; then

            echo "OK: $SERVICE đang chạy"

        else

            echo "CẢNH BÁO: $SERVICE KHÔNG chạy"

        fi

    done

}

echo "=== Health Check: $(date) ==="

check_disk
check_services
echo "=== Done ==="

