<template>
  <div>
      <div class="form-row align-items-center">
        &nbsp;&nbsp;&nbsp;<i>Фильтры:</i>
          <div class="col-auto my-1">
            <select v-model="selectedRegion" class="form-control" id="exampleFormControlSelect1">
              <option v-for="reg in regions">{{ reg }}</option>
            </select>
          </div>
          <div class="col-auto my-1">
            <select v-model="selectedLocation" class="form-control" id="exampleFormControlSelect1">
              <option v-for="loc in locations" v-bind:value="loc.id">{{ loc.name }}</option>
            </select>
          </div>

          <div class="col-auto my-1">
            <button type="button" name="button" class="btn btn-success" @click="findHotels">Найти</button>
            <button type="button" name="button" class="btn btn-light" @click="clearFilters">Очистить фильтры</button>
          </div>

        </div>

  </div>
</template>

<script>
export default {
    props: {
      region_in: String,
      location_in:{
        type: Number,
        default: 0
      },
    },
    data: function () {
      return {
        regions: Array,
        selectedRegion: '',
        locations: Array,
        selectedLocation: 0
      }
  },
  mounted: async function() {
    const response = await fetch('/tours/get_regions');
    const regins = await response.json();

    this.selectedRegion = this.region_in;
    this.selectedLocation = this.location_in;

    this.regions = regins;
  },
  methods: {
    findHotels: async function(){
      window.location.href = `/hotels?location_id=${this.selectedLocation}`;
    },
    clearFilters: async function(){
      this.selectedRegion = '';
      this.selectedLocation = 0;
      window.location.href = `/hotels?location_id=${this.selectedLocation}`;
    }
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
p {
  font-size: 2em;
  text-align: center;
}
</style>
