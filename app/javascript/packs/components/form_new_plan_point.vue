<template>
  <div>

    <div class="alert alert-warning" role="alert" v-for="error in errors">
      {{ error }}
    </div>

     <form>
       <div class="form-group">
         <div class="container-fluid page">
            <div class="row">
                <div class="offset-4 col-6">
                   <label for="">Дата</label>
                   <input type="date" name="" class="form-control" value="" v-model="planPoint.day_date" placeholder="дд-мм-гггг">
                </div>
              </div>
            </div>
          </div>

          <div class="form-group">
            <div class="container-fluid page">
               <div class="row">
                   <div class="offset-4 col-6">
                     <label for="">Время с</label>
                     <input type="time" name="" class="form-control" value="" v-model="planPoint.from_time" placeholder="чч:мм">
                   </div>
                 </div>
               </div>
             </div>

             <div class="form-group">
               <div class="container-fluid page">
                  <div class="row">
                      <div class="offset-4 col-6">
                       <label for="">Время по</label>
                        <input type="time" class="form-control" name="" value="" v-model="planPoint.to_time" placeholder="чч:мм">
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <div class="container-fluid page">
                     <div class="row">
                         <div class="offset-4 col-6">
                           <div class="" v-if="selectedTour != 0">
                             <h4>Выбранный тур: </h4>
                               <div class="card" style="width: 18rem; margin:20px">
                                 <img v-bind:src="selectedTour.image.picture" alt="image" class="card-img-top">
                                 <div class="card-body">
                                   <h4>{{ selectedTour.name  }}</h4>
                                   <p class="card-text">{{ selectedTour.location.name }}, {{ selectedTour.location.region }}</p>
                                 </div>
                                </div>
                              </div>
                        </div>
                       </div>
                     </div>
                  </div>

                  <div class="form-group">
                    <div class="container-fluid page">
                       <div class="row">
                           <div class="offset-4 col-6">
                              <button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModalCenter">
                                Выбрать тур
                              </button>
                          </div>
                        </div>
                      </div>
                    </div>

      <!-- MODAL -->

      <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalCenterTitle">Выберите тур</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="" v-for="tour in tours" style="margin:10px">
                <input type="radio" v-bind:value="tour" v-model="selectedTour">
                <label style="font-size:20px">{{ tour.name }} <br> <img v-bind:src="tour.image.picture" alt="Image" style="height:75px;border-radius:5px"> </label>
                <br>
              </div>
            </div>

            <div class="modal-footer">
              <button type="button" @click="chosingTour" class="btn btn-primary" data-dismiss="modal">Ок</button>
            </div>
          </div>
        </div>
      </div>


      <div class="form-group">
        <div class="container-fluid page">
           <div class="row">
               <div class="offset-4 col-6">
                 <button type="button" name="button" class="btn btn-primary btn-lg" @click="sendData">Сохранить</button>
               </div>
             </div>
           </div>
          </div>
     </form>
  </div>
</template>

<script>
export default {
  props: {
    user_id: {
      default: 0,
      required: true
    },
    plan_in_id: {
      default: 0,
      required: true
    }
  },
  data: function () {
    return {
      planPoint: {
        plan_id: this.plan_in_id,
        tour_id: 0,
        from_time: null,
        to_time: null,
        day_date: null
      },
      tours: Array,
      selectedTour: 0,
      errors: Array
    }
  },
  methods: {
    chosingTour: function(){
      this.planPoint.tour_id = this.selectedTour.id;
    },
    sendData: async function(){
      var self = this;
      const response = await fetch(`/plans/${this.plan_in_id}/plan_points`, {
        method: 'POST',
        body: JSON.stringify(self.planPoint),
        headers:{
          'Content-Type': 'application/json'
        }
      });

      const result = await response.json();
      if(result.errors){
        self.errors = result.errors;
      }
      else {
        window.location.href = `/plans/${this.plan_in_id}`;
      }
    }
  },
  mounted: async function(){
    const response = await fetch(`/users/${this.user_id}/tours`);
    const trs = await response.json();
    this.tours = trs;
  }
}
</script>
