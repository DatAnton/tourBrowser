<template>
  <div>
    <input type="number" min="0" v-model="count_out.count_of_hotels" style="width:50px">
    <button type="button" @click="save" name="button" v-if="count_out.count_of_hotels != count_in">
      <img src="../images/galochka.png" style="height:20px">
    </button>
  </div>
</template>

<script>
export default {
  props: {
    count_in: {
      type: Number,
      default: 0
    },
    user_id_in: {
      type: Number,
      default: 0
    }
  },
  data: function () {
    return {
      count_out: {
        count_of_hotels: this.count_in,
        user_id: this.user_id_in
      }
    }
  },
  methods: {
    save: async function(){
      var self = this;
      const response = await fetch(`/users/edit_count_of_hotels`, {
        method: 'PUT',
        body: JSON.stringify(self.count_out),
        headers:{
          'Content-Type': 'application/json'
        }
      });
      var result = await response.json();
      if (result) {
        self.count_in = self.count_out.count_of_hotels;
      }

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
