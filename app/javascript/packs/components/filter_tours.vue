<template>
  <div class="">
    <hr>
    <form>
      <div class="form-row align-items-center">
        &nbsp;&nbsp;&nbsp;<i>Filters:</i>
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
          <input type="checkbox" v-model="sortBySavings">
          <label for="horns">Sort by rating</label>
        </div>

        <div class="col-auto my-1">
          <a v-bind:href="filterString" class="btn btn-primary">FIND</a>
          <button type="button" class="btn btn-light" @click="clearFilters">Clear filters</button>
        </div>
      </div>
    </form>
  <hr>
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
    sort_in: {
      type: Boolean,
      default: false
    }
  },
  data: function () {
    return {
      regions: Array,
      selectedRegion: '',
      locations: Array,
      selectedLocation: 0,
      sortBySavings: this.sort_in,
      filterString: ''
    }
  },
  methods: {
    clearFilters: function(){
      this.selectedRegion = '';
      this.selectedLocation = 0;
      this.sortBySavings = false;
      window.location.href = '/tours';
    }
  },
  mounted: async function() {
    const response = await fetch('/tours/get_regions');
    const regins = await response.json();

    this.selectedRegion = this.region_in;
    this.selectedLocation = this.location_in;


    this.filterString = `/tours?location_id=${this.selectedLocation}&sort_by_savings=${this.sortBySavings}`;
    this.regions = regins;
  },
  watch: {
    selectedRegion: async function(){
      const response = await
        fetch(`/tours/get_locations_by_region?region=${this.selectedRegion}`);
      const locatins = await response.json();
      this.locations = locatins;
    },
    selectedLocation: function(){
      this.filterString = `/tours?location_id=${this.selectedLocation}&sort_by_savings=${this.sortBySavings}`;
    },
    sortBySavings: function(){
      this.filterString = `/tours?location_id=${this.selectedLocation}&sort_by_savings=${this.sortBySavings}`;
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
