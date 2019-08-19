<template>
  <div>
    <div class="d-flex align-items-center" v-if="saving">
      <strong>Saving...</strong>&nbsp;&nbsp;&nbsp;
      <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Loading...</span>
      </div>
    </div>

    <div class="alert alert-warning" role="alert" v-for="error in errors">
      {{ error }}
    </div>

    <div class="form-group">
      <label for="">Name</label>
      <input type="text" v-model="tour.name" class="form-control" placeholder="What is name?">
    </div>
    <div class="form-group">
      <label for="">Description</label>
      <textarea v-model="tour.description" class="form-control" placeholder="What you will see?"></textarea>
    </div>

    <div class="form-group">
      &nbsp;<input type="checkbox" v-model="tour.is_private">
      <label for="horns">private?</label><br>
    </div>

    <h3 class="text-center">Select location</h3>
    <div class="row">
      <div class="col">
        <select v-model="selectedRegion" class="form-control">
          <option v-for="regin in regions" v-bind:value="regin">{{ regin }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="tour.location_id" class="form-control">
          <option v-for="location in locations" v-bind:value="location.id">{{ location.name }}</option>
        </select>
      </div>
    </div>

    <h3 class="text-center">Photos</h3>
    <hr>

    <label for="">Choose main image:</label>
    <br>
    <img v-if="tour.main_image != null" v-bind:src="tour.main_image"
      class="uploading-image"/>
    <input type="file" accept="image/jpeg" @change="uploadImage">
    <h4>Gallery:</h4>
    <div class="" v-for="imag in tour.images">
      <img v-bind:src="imag"
      class="uploading-image"/>
      <button type="button" name="button" class="btn btn-danger" @click="deleteImage(imag)">delete</button>
      <br>
    </div>
    <label for="">Select other images:</label>
    <input type="file" multiple="multiple" accept="image/jpeg" @change="uploadGallery"><br>

    <button type="button" name="button" class="btn btn-primary" style="margin:10px" v-on:click="sendData" v-bind:disabled="saving">Create</button>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      tour: {
        name: '',
        description: '',
        location_id: 0,
        main_image: null,
        is_private: false,
        images: []
      },
      regions: Array,
      selectedRegion: '',
      locations: Array,
      errors: Array,
      saving: false
    }
  },
  methods: {
    deleteImage(img){
      this.tour.images = this.tour.images.filter(function(item) {
        return item !== img
      });
    },
    uploadImage(e){
        const image = e.target.files[0];
        const reader = new FileReader();
        reader.readAsDataURL(image);
        reader.onload = e =>{
            this.tour.main_image = e.target.result;
        };
    },
    uploadGallery(e){
      var images = e.target.files;
      var image;
      for(var i = 0; i < e.target.files.length; i++)
      {
        const reader = new FileReader();
        image = images[i];
        reader.readAsDataURL(image);
        reader.onload = e =>{
          this.tour.images.push(e.target.result);
        };
      }

    },
    sendData: async function(){
      var self = this;
      this.saving = true;
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
        this.saving = false;
      }
      else {
        window.location.href = '/tours';
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
