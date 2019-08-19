<template>
  <div>
    <h2 class="text-center">{{ plan.name }}
      <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#exampleModalCenter">
        <img src="../images/pencil.png" style="height:20px">
      </button>
    </h2>

      <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalCenterTitle">Edit plan name</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <input type="text" class="form-control" id="formGroupExampleInput" placeholder="Name" v-model="plan.name">
              <br><br>
              <button type="button" name="button" @click="destroyPlan" class="btn btn-danger" data-confirm="Are you sure to delete this plan?">Destroy</button>
            </div>

            <div class="modal-footer">
              <button type="button" @click="editName" class="btn btn-primary" data-dismiss="modal">Edit</button>
            </div>
          </div>
        </div>
      </div>
  </div>

</template>

<script>
export default {
  props: ['plan_in_id', 'plan_in_name'],
  data: function () {
    return {
      plan: {
        id: this.plan_in_id,
        name: this.plan_in_name
      }
    }
  },
  methods: {
    editName: async function(){
      var self = this;
      const response = await fetch(`/plans/${this.plan.id}`, {
        method: 'PUT',
        body: JSON.stringify(self.plan),
        headers:{
          'Content-Type': 'application/json'
        }
      });
      const result = await response.json();
    },
    destroyPlan: async function(){
      var self = this;
      const response = await fetch(`/plans/${this.plan.id}`, {
        method: 'DELETE',
        body: JSON.stringify(self.plan),
        headers:{
          'Content-Type': 'application/json'
        }
      });
      window.location.href = '/plans';
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
