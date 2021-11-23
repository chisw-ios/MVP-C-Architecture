project_dir=$(pwd)
project_name="PROJECT_NAME"
echo 'Enter project name'
read project_name

git clone -b feature/Xcodegen https://github.com/hetmanskiy/MVP-Coordinator.git ./$project_name

sed -i -e 's#\$PROJECT_NAME\$#'$project_name'#g' $project_name/project.yml

sed -i -e 's#\$PROJECT_PATH\$#'$project_dir/$project_name'#g' $project_name/project.yml

sed -i -e 's#\$PROJECT_NAME\$#'$project_name'#g' $project_name/Podfile

rm $project_name/project.yml-e
rm $project_name/Podfile-e
rm $project_name/.git
cd ./$project_name

xcodegen generate

arch_name="$(uname -m)"
 
if [ "${arch_name}" = "x86_64" ]; then
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo "Running on Rosetta 2"
    else
        pod install
    fi
elif [ "${arch_name}" = "arm64" ]; then
    arch -x86_64 pod update  --repo-update
else
    echo "Unknown architecture: ${arch_name}"
fi


