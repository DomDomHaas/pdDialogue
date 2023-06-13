<template>
  <li class="ma-1 pa-0">
<!--    <span class="tf-nc">{{ title }}</span>

    <ul v-if="children">

      <dialogue-item v-for="(dialogue, index) of children"
                     :title="dialogue.id"
                     :text="dialogue.text"
                     :children="dialogue.options"
                     :key="`${title}_child_${index}`"
      >

      </dialogue-item>
    </ul>-->


    <div class="tf-nc pa-1 shrink" >
      <v-col class="shrink pa-0">
        <v-text-field :model-value="title"
                      label="title"
                      hide-details
                      density="compact"
                      variant="outlined"
                      class="pa-1">
        </v-text-field>
      </v-col>

      <v-col class="shrink pa-0">
        <v-textarea :model-value="text"
                    label="text"
                    class="pa-1"
                    hide-details
                    density="compact"
                    auto-grow>

        </v-textarea>
      </v-col>

      <div v-if="next">
        <v-col class="shrink pa-1">
          <v-text-field :model-value="next"
                        label="next"
                        density="compact"
                        variant="outlined"
                        hide-details >
          </v-text-field>
        </v-col>
      </div>

    </div>

    <ul >

      <dialogue-item v-if="children"
                     v-for="(dialogue, index) of children"
                     :title="dialogue.id"
                     :text="dialogue.text"
                     :next="dialogue.next"
                     :children="dialogue.options"
                     :key="`${title}_child_${index}`"
                     @addItem="catchAddItem(dialogue.id)"
      />

      <DialogueItemAdd @addItem="catchAddItem(title)" />

    </ul>

  </li>
</template>

<script>
import DialogueItemAdd from "@/components/DialogueItemAdd.vue";
const DialogueItem = import("@/components/DialogueItem.vue")

export default {
  name: 'DialogueItem',
  props: {
    title: String,
    text: String,
    width: {
      type: Number,
      default: 200,
    },
    height: {
      type: Number,
      default: 300,
    },
    children: {
      type: Array,
      default: undefined,
    },
    next: String,
  },
  components: {
    DialogueItemAdd,
    DialogueItem,
  },
  computed: {
  },
  methods: {
    catchAddItem(parent) {
      this.$emit('addItem', parent)
    },
  },
  data: () => ({
  }),
};

</script>
