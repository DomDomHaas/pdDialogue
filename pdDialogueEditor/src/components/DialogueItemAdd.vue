<template>
  <li class="ma-1 pa-0">

    <div class="tf-nc pa-1 shrink" >
      <v-btn icon="mdi-plus-box"
             @click="$emit('addItem')"
             density="comfortable">
      </v-btn>
    </div>

  </li>
</template>

<script>

export default {
  name: 'DialogueItemAdd',
  props: {
  },
  computed: {
  },
  data: () => ({
  }),
};

</script>
