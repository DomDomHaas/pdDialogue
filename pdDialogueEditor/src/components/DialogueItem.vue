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


    <div class="tf-nc pa-0 shrink" >
      <v-container class="pa-1"
                   :fluid="true" >

      <div style="position: absolute; right: 0; top: 0; z-index: 10;"
            class="px-1">
        <v-btn class="ma-0"
                 icon="mdi-close"
                 color="red"
                 size="small"
                 density="compact"
                 @click="$emit('clearItem', title)"
        />
      </div>

      <v-row no-gutters
             style="align-items: center;">
        <v-col class="grow pa-0">
          <v-text-field :model-value="title"
                        label="Title"
                        hide-details
                        density="compact"
                        variant="outlined"
                        class="pa-1">
          </v-text-field>
        </v-col>

      </v-row>

      <v-row no-gutters >
        <v-col >
          <v-textarea :model-value="text"
                      label="Text"
                      class="pa-1"
                      hide-details
                      density="compact"
                      auto-grow>

          </v-textarea>
        </v-col>
      </v-row>

      <v-row v-if="!children"
             no-gutters
              class="pa-1">
        <v-col >
          <v-text-field :model-value="next"
                        label="Next Dialogue"
                        density="compact"
                        variant="outlined"
                        hide-details >
          </v-text-field>
        </v-col>
      </v-row>

      </v-container>

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
                     @clearItem="catchClearItem(dialogue.id)"
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
    catchClearItem(parent) {
      this.$emit('clearItem', parent)
    },
  },
  data: () => ({
  }),
};

</script>
