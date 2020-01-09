PROJECT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
echo "Project dir is $PROJECT_DIR"

# Load build number & version number from file
export BUILD_NUMBER=$(cat build_conf/BUILD_NUMBER)
export VERSION_NUMBER=$(cat build_conf/VERSION_NUMBER)
export PACKAGE_NAME=$(cat build_conf/PACKAGE_NAME)

# Increment the build number for each build
export BUILD_NUMBER=$(($BUILD_NUMBER+1))
echo "$BUILD_NUMBER" > $PROJECT_DIR/build_conf/BUILD_NUMBER

# Trigger conda build process
conda build $PROJECT_DIR

# Copy conda build artefact to private repo directory
export CONDA_BUILD_DIR=$(cat build_conf/CONDA_BUILD_DIR)
export CONDA_REPO_DIR=$(cat build_conf/CONDA_REPO_DIR)
echo "Copying all files under $CONDA_BUILD_DIR/$PACKAGE_NAME-$VERSION_NUMBER.$BUILD_NUMBER* into $CONDA_REPO_DIR"
cp $CONDA_BUILD_DIR/$PACKAGE_NAME-$VERSION_NUMBER.$BUILD_NUMBER* $CONDA_REPO_DIR

# Perform conda index to update repo metadata
conda index $CONDA_REPO_DIR

# Push build number back to git
echo "Sync with git and push build number back to git"
git add .
git commit -m "Build package -> increment build number to $BUILD_NUMBER"
git push origin master
