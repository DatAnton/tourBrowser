<template>
  <div>
    <ul class="list-group">
      <li class="list-group-item" v-for="comm in comments">
        <img v-bind:src="comm.author.user.avatar.url" alt="avatar" style="height:30px;width:30px;border-radius:5px">
        <div class="border border-info" style="display:inline">
          {{ comm.author.user.username }}:
        </div>
         {{ comm.body }}
      </li>

      </ul>
    <form class="form-inline">
      <textarea class="form-control w-75 p-3" placeholder="Your comment..." id="exampleFormControlTextarea1" rows="2" v-model="comment.body"></textarea>
      &nbsp;&nbsp;&nbsp;
      <button type="button" @click="addComment" class="btn btn-primary mb-2">Add</button>
    </form>
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
