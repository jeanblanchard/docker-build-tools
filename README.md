## Common tools to build my docker images using Circle CI or the command line
 
- Add this project as a git submodule to the build folder.
- Copy circle-sample.yml as circle.yml at the project root.
- Configure the variables IMAGE_NAME, IMAGE_TAGS and IMAGE_OWNER in circle.yml
- Configure the variables HUB_USERNAME and HUB_PASSWORD in the Circle CI project settings
- Copy test-sample.sh as test.sh at the project root, and write your test in it
- Adjust if needed.
