<template>
  <div>
    <input type="checkbox" v-model="free">
    <label for="horns">Вы имеете свободные места?</label><br>
  </div>
</template>

<script>
export default {
  props: {
    status_in: {
      type: Boolean,
      default: false
    },
    hotel_id: {
      type: Number,
      default: 0
    }
  },
  data: function () {
    return {
      free: this.status_in
    }
  },
  watch: {
    free: async function(){
      var self = this;
      var data = { free: this.free };
      const response = await fetch(`/hotels/${this.hotel_id}`, {
        method: 'PUT',
        body: JSON.stringify(data),
        headers:{
          'Content-Type': 'application/json'
        }
      });
      const result = await response.json();
    }
  }
}
</script>
