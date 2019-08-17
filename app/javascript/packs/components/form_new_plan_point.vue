<template>
  <div>
    <div class="alert alert-warning" role="alert" v-for="error in errors">
      {{ error }}
    </div>

     <form>
       <br>
       <label for="">Day:</label>
       <input type="date" name="" value="" v-model="planPoint.day_date">

       <br>
       <label for="">From</label>
       <input type="time" name="" value="" v-model="planPoint.from_time">
       <label for="">To</label>
       <input type="time" name="" value="" v-model="planPoint.to_time">


       <h4>Chosen tour: </h4>
       <div class="" v-if="selectedTour != 0">
         <h5>{{ selectedTour.name  }}</h5>
         <h6>Region: {{ selectedTour.location.name }}, {{ selectedTour.location.region }}</h6>
         <img v-bind:src="selectedTour.image.picture" alt="image" style="height:100px">
       </div>

      <br>
      <button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModalCenter">
        Choose tour
      </button>

      <!-- MODAL -->

      <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalCenterTitle">Choose tour</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="" v-for="tour in tours">
                <input type="radio" v-bind:value="tour" v-model="selectedTour">
                <label>{{ tour.name }} <br> <img v-bind:src="tour.image.picture" alt="Image" style="height:75px;"> </label>
                <br>
              </div>
            </div>

            <div class="modal-footer">
              <button type="button" @click="chosingTour" class="btn btn-primary" data-dismiss="modal">Ok</button>
            </div>
          </div>
        </div>
      </div>
      <br><br>
      <button type="button" name="button" class="btn btn-primary" @click="sendData">Save</button>
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
