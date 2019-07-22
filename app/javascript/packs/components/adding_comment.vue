<template>
  <div>
    <p v-for="comm in comments">{{ comm.body }} -_- {{ comm.author.user.username }}
      <img v-bind:src="comm.author.user.avatar.url" alt="avatar" style="height:30px;width:30px;border-radius:5px"> </p>
    <textarea v-model="comment.body"></textarea>
    <button type="button" @click="addComment">Comment</button>
  </div>
</template>

<script>
export default {
  props: ['in_tour_id'],
  data: function () {
    return {
      comment: {
        body: '',
        tour_id: 0,
        user_id: 0
      },
      errors: Array,
      comments: this.getAllComments()
    }
  },
  methods: {
    addComment: async function(){
      var self = this;
      this.comment.tour_id = this.in_tour_id;
      const response = await fetch(`/tours/${this.in_tour_id}/comments`, {
        method: 'POST',
        body: JSON.stringify(self.comment),
        headers:{
          'Content-Type': 'application/json'
        }
      });

      const result = await response.json();
      if(result.errors){
        self.errors = result.errors;
      }
      else {
        self.comment.body = '';
        self.getAllComments();
      }
    },
    getAllComments: async function(){
      const response = await fetch(`/tours/${this.in_tour_id}/comments.json`);
      const comms = await response.json();
      this.comments = comms;
    }
  }
}
</script>

<style>

</style>
