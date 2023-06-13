<template>
  <div class="pa-0"
       style="display: flex;">
    <div class="pa-3">
      Add Chapter

      <v-btn icon="mdi-book-plus"
             @click="$emit('addChapter', parent)"
             density="comfortable">
      </v-btn>
    </div>

  </div>

</template>

<script>
export default {
  name: 'DialogueChapterAdd',
  props: {
    parent: String,
  },
  computed: {
  },
  data: () => ({
  }),
};

</script>
