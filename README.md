## Common tools to build my docker images using Circle CI or the command line
 
- Add this project as a git submodule to the build folder.
- Copy circle-sample.yml as circle.yml at the project root.
- Configure the variables IMAGE_NAME, IMAGE_TAGS and IMAGE_OWNER in circle.yml
- Configure the variables HUB_USERNAME, HUB_PASSWORD and HUB_EMAIL in the Circle CI project settings
- write ./test.sh
- Adapt if needed.
