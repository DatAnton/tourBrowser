/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue/dist/vue.esm.js';
import TurbolinksAdapter from 'vue-turbolinks'

import App from './components/app.vue'
import FormNewTour from './components/form_new_tour.vue'
import FormEditTour from './components/form_edit_tour.vue'
import FormNewPlanPoint from './components/form_new_plan_point.vue'
import AddingComment from './components/adding_comment.vue'
import SavingTour from './components/saving_tour.vue'
import FilterTours from './components/filter_tours.vue'
import NewPlanModal from './components/new_plan_modal.vue'
import EditPlan from './components/edit_plan.vue'
import CountOfHotels from './components/count_of_hotels.vue'
import NewHotelForm from './components/new_hotel_form.vue'
import HotelFreeAct from './components/hotel_free_act.vue'
import FilterHotels from './components/filter_hotels.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#root',
    data: {
      message: "Can you say hello?"
    },
    components: { App, FormNewTour, FormEditTour, AddingComment, SavingTour,
      FormNewPlanPoint, FilterTours, NewPlanModal, EditPlan, CountOfHotels,
      NewHotelForm, HotelFreeAct, FilterHotels }
  })
})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
