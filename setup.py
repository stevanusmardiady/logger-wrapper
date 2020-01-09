import setuptools, os, subprocess

# Locate config file
BUILD_NUMBER = os.path.dirname(os.path.realpath(__file__)) + "/build_conf/BUILD_NUMBER"
VERSION_NUMBER = os.path.dirname(os.path.realpath(__file__)) + "/build_conf/VERSION_NUMBER"
PACKAGE_NAME = os.path.dirname(os.path.realpath(__file__)) + "/build_conf/PACKAGE_NAME"

# Retrieve config value from config file
BUILD_NUMBER = subprocess.run(["cat", BUILD_NUMBER], capture_output=True, text=True).stdout.split("\n")[0]
VERSION_NUMBER = subprocess.run(["cat", VERSION_NUMBER], capture_output=True, text=True).stdout.split("\n")[0]
PACKAGE_NAME = subprocess.run(["cat", PACKAGE_NAME], capture_output=True, text=True).stdout.split("\n")[0]

setuptools.setup(
    name=PACKAGE_NAME,
    version=VERSION_NUMBER + "." + BUILD_NUMBER,
    author="expecc",
    author_email="expecc@expecc.com",
    description="Common package for logging purpose",
    packages=setuptools.find_packages(),
    include_package_data=True
)