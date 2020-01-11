import '../images/ektar.svg';

import '../css/application';

import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

Rails.start();
Turbolinks.start();

import { Flash } from '../js/flash.js';

Flash.setup();

document.addEventListener(
  'turbolinks:load',
  () => Flash.setup(),
  {
    once: true,
  },
);

document.addEventListener(
  'turbolinks:render',
  () => Flash.setup(),
);

document.addEventListener(
  'turbolinks:before-cache',
  () => Flash.clean(),
)

document.addEventListener(
  'ajax:before',
  () => Turbolinks.clearCache(),
);

document.addEventListener(
  '[data-remote]',
  () => Turbolinks.clearCache(),
);
