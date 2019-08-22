<template>
  <div>
    <button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#exampleModalCenter">
      Новый план
    </button>

    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalCenterTitle">Новый план</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <input type="text" class="form-control" id="formGroupExampleInput" placeholder="Имя" v-model="plan.name" autofocus="true">
          </div>

          <div class="modal-footer">
            <button type="button" @click="sendData" class="btn btn-primary" data-dismiss="modal">Создать</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      plan: {
        id: Number,
        name: ''
      }
    }
  },
  methods: {
    sendData: async function(){
      console.log(this.plan.name);
      var self = this;
      const response = await fetch(`/plans`, {
        method: 'POST',
        body: JSON.stringify(self.plan),
        headers:{
          'Content-Type': 'application/json'
        }
      });
      const result = await response.json();
      window.location.href = `/plans/${result.id}`;
    }
  }
}
</script>
