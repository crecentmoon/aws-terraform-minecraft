cd /storage | mkdir minecraft | cd minecraft

pwd
==============出力結果==============
# pwd を実行後に下記になっていることを確認
/home/ec2-user/minecraft
===================================

# BuildToolsを取得
sudo wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

# バージョンを指定してビルド(1.XX.X など)
java -jar BuildTools.jar --rev 1.19.4
==============出力結果==============
~~
Success! Everything completed successfully. Copying final .jar files now.
Copying spigot-1.19.4-R0.1-SNAPSHOT-bootstrap.jar to /home/ec2-user/minecraft/./spigot-1.19.4.jar
  - Saved as ./spigot-1.19.4.jar
===================================

vi Minecraft_start.sh

==============追加内容==============
#!/bin/sh
java -Xmx3500M -Xms2048M -jar /storage/minecraft/spigot-1.19.4.jar nogui
===================================

chmod +x Minecraft_start.sh

sh Minecraft_start.sh

sed -i -e "s/eula=false/eula=true/g" eula.txt
sh Minecraft_start.sh