# MotionScrub

A quick (and very very dirty, at the moment) work around to allow sharing of 120FPS slow-motion videos with social networks that haven't been "blessed" by iOS 7's built-in selection list.

## Disclaimer

This code is an unapologetically terrible Q&D to fix a sharing problem I have right now.

## What does it do?

It's stupid simple. It uses the inbuilt UIImagePickerViewController to do most of the hard work and then AVAssetExportSession to give a little bit of flexibility in the output choice. Then it saves to camera roll.