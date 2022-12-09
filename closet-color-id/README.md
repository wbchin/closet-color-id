#  MCloset

This application plans on helping fashion become an accessible and feasible topic for the color-blind and visually impaired community (including but not limited to low vision, visually impaired, and blind). The app will be an outfit generator tool that uses the iPhone’s camera to take photos of articles of clothing, uses APIs to discern the main colors of the image, stores these images with tags, and creates outfit combinations that fit the current fashion trends. Our goal is for our users to dress confidently with the help of our app.

## Testing

The only file we test in this application is the ViewModel. Using CoreData, all models are automatically generated, and thus there are no model files to test. Instead we focus on ViewModel testing, which mainly consists of coredata functionality. Furthermore, due do catch save blocks, our ViewModel test coverage is below 90%, as many catch blocks are counted as untested, when the setup of our functions don't allow for these blocks to be entered. Essentially, these blocks are here for incorrect CoreData saves (such as saving string values to an integer value field), when our functions parameters already account for type matching. The purpose of including these catch blocks was such that XCode build would succeed. Additionally, enums and color family functions are uncovered since they are purely giving names for colors based on hue integer values. 


