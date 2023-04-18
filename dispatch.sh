echo -e "\e[36m>>>>>>>>> Install Golang <<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[36m>>>>>>>>> Add Application User <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create Application Directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>>> Download App Content <<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e[36m>>>>>>>>> Unzip App Content <<<<<<<<\e[0m"
unzip /tmp/dispatch.zip
cd /app

echo -e "\e[36m>>>>>>>>> Build the Application <<<<<<<<\e[0m"
go mod init dispatch
go get
go build

echo -e "\e[36m>>>>>>>>> Copy dispatch SystemD file <<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/dispatch.service dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[36m>>>>>>>>> Start Dispatch Service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch