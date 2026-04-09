-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- WISHLIST:
-- 1. Fix cyberdream colourscheme on Snacks.dashboard (buttons are not using the correct colours)
-- 2. Fix Kotlin neotest setup (not running all tests (<l>tT))
-- 3. Probably need to figure out the Kotlin DAP too
-- 4. Improve DAP/neotest usability as a whole, I think there are a lot of features I'm not using
-- 5. Learn to use marks better
-- 6. Make a custom plugin that extends from Snacks.nvim and allows the user to choose their dashboard art from a custom
-- 		list/table defined in a file
-- 7. Better lazygit integration
-- 		- currently starting up a bunch of different tabs/workspaces
-- 		- terrible experience at handling conflicts
-- 		- try to add custom script for getting the message templates
-- 8. Init nvim with the dashboard even if we pass it a directory
