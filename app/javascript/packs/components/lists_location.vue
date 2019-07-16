<template>
  <div>
    <div class="alert alert-warning" role="alert" v-for="error in errors">
      {{ error }}
    </div>


    <label for="">Name</label><br>
    <input type="text" v-model="tour.name" placeholder="What is name?">
    <br>
    <textarea v-model="tour.description" placeholder="What you will see?">
    </textarea><br>

    <label for="">Select location</label><br>
    <label for="">Region</label><br>
    <select v-model="selectedRegion">
      <option v-for="regin in regions" v-bind:value="regin">{{ regin }}</option>
    </select>
    <br>
    <label for="">Location</label>
    <select v-model="tour.location_id">
      <option v-for="location in locations" v-bind:value="location.id">{{ location.name }}</option>
    </select><br>
    <button type="button" name="button" v-on:click="sendData">Save</button>

  </div>
</template>

<script>
export default {
  data: function () {
    return {
      tour: {
        name: '',
        description: '',
        location_id: 0
      },
      regions: Array,
      selectedRegion: '',
      locations: Array,
      errors: Array
    }
  },
  methods: {
    sendData: async function(){
      var self = this;
      const response = await fetch('/tours', {
        method: 'POST',
        body: JSON.stringify(self.tour),
        headers:{
          'Content-Type': 'application/json'
        }
      });

      const result = await response.json();
      if(result.errors){
        self.errors = result.errors;
      }
      else {
        // change to tour_index
        window.location.href = '/users/profile';
      }
    }
  },
  mounted: async function() {
    const response = await fetch('/tours/get_regions');
    const regins = await response.json();
    this.regions = regins;
  },
  watch: {
    selectedRegion: async function(){
      const response = await
        fetch(`/tours/get_locations_by_region?region=${this.selectedRegion}`);
      const locatins = await response.json();
      this.locations = locatins;
    }
  }
}
</script>

<style scoped>

</style>
