import ReactOnRails from "react-on-rails";

import { make as HelloWorld } from "../bundles/HelloWorld/components/HelloWorld.bs";

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld,
});
