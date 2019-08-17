<template>
  <div>
    <button v-if="save_active" class="btn btn-primary" type="button" name="button" @click="saveTour">save</button>
    <button v-else class="btn btn-danger" type="button" name="button" @click="deleteTour">remove</button>
  </div>
</template>

<script>
export default {
  props: {
    user_id: {
      type: Number,
      required: true
    },
    tour_id: {
      type: Number,
      required: true
    },
    is_saved: {
      type: Boolean,
      required: true
    }
  },
  data: function () {
    return {
      save_active: !this.is_saved
    }
  },
  methods: {
    deleteTour: async function(){
      var self = this;
      var relation = { user_id: this.user_id, tour_id: this.tour_id };
      const response = await fetch(`/tours_and_users/delete`, {
        method: 'DELETE',
        body: JSON.stringify(relation),
        headers:{
          'Content-Type': 'application/json'
        }
      });
      this.save_active = true;
    },
    saveTour: async function(){
      var self = this;
      var relation = { user_id: this.user_id, tour_id: this.tour_id };
      const response = await fetch(`/tours_and_users`, {
        method: 'POST',
        body: JSON.stringify(relation),
        headers:{
          'Content-Type': 'application/json'
        }
      });
      this.save_active = false;
    }

  }
}
</script>

<style>

</style>
