npm install;
npm run build;
cd dist;
npm install --only=production
docker build . -t backend:latest;
if [ $? -ne 0 ]
then 
    echo "Failed to build the image... Exitting with code $?";
    exit;
fi;
cd ..;