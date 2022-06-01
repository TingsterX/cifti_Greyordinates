# -------------------------------
# 10k surface and 3mm volume
pushd 3mm_10k
n=10242
wb_command -surface-create-sphere ${n} R.sphere.10k_fs_LR.surf.gii
wb_command -surface-flip-lr R.sphere.10k_fs_LR.surf.gii L.sphere.10k_fs_LR.surf.gii
wb_command -set-structure L.sphere.10k_fs_LR.surf.gii CORTEX_LEFT
wb_command -set-structure R.sphere.10k_fs_LR.surf.gii CORTEX_RIGHT

3dresample -dxyz 3 3 3 -inset $FSLDIR/data/standard/MNI152_T1_1mm.nii.gz -prefix MNI152_T1_3mm.nii.gz -rmode Li
3dresample -dxyz 3 3 3 -inset ../91282_Greyordinates/Atlas_ROIs.2.nii.gz -prefix Atlas_ROIs.3.nii.gz -rmode NN
wb_command -volume-label-import Atlas_ROIs.3.nii.gz Atlas_ROIs.table.txt Atlas_ROIs.3.nii.gz

wb_command -metric-resample ../91282_Greyordinates/L.atlasroi.32k_fs_LR.shape.gii ../91282_Greyordinates/L.sphere.32k_fs_LR.surf.gii L.sphere.10k_fs_LR.surf.gii BARYCENTRIC L.atlasroi.10k_fs_LR.shape.gii -largest
wb_command -metric-resample ../91282_Greyordinates/R.atlasroi.32k_fs_LR.shape.gii ../91282_Greyordinates/R.sphere.32k_fs_LR.surf.gii R.sphere.10k_fs_LR.surf.gii BARYCENTRIC R.atlasroi.10k_fs_LR.shape.gii -largest
popd

# -------------------------------
# 2k surface and 3mm volume
pushd 4mm_2k
n=2562
wb_command -surface-create-sphere ${n} R.sphere.2k_fs_LR.surf.gii
wb_command -surface-flip-lr R.sphere.2k_fs_LR.surf.gii L.sphere.2k_fs_LR.surf.gii
wb_command -set-structure L.sphere.2k_fs_LR.surf.gii CORTEX_LEFT
wb_command -set-structure R.sphere.2k_fs_LR.surf.gii CORTEX_RIGHT

3dresample -dxyz 4 4 4 -inset $FSLDIR/data/standard/MNI152_T1_1mm.nii.gz -prefix MNI152_T1_4mm.nii.gz -rmode Li
3dresample -dxyz 4 4 4 -inset ../91282_Greyordinates/Atlas_ROIs.2.nii.gz -prefix Atlas_ROIs.4.nii.gz -rmode NN
wb_command -volume-label-import Atlas_ROIs.4.nii.gz Atlas_ROIs.table.txt Atlas_ROIs.4.nii.gz

wb_command -metric-resample ../91282_Greyordinates/L.atlasroi.32k_fs_LR.shape.gii ../91282_Greyordinates/L.sphere.32k_fs_LR.surf.gii L.sphere.2k_fs_LR.surf.gii BARYCENTRIC L.atlasroi.2k_fs_LR.shape.gii -largest
wb_command -metric-resample ../91282_Greyordinates/R.atlasroi.32k_fs_LR.shape.gii ../91282_Greyordinates/R.sphere.32k_fs_LR.surf.gii R.sphere.2k_fs_LR.surf.gii BARYCENTRIC R.atlasroi.2k_fs_LR.shape.gii -largest

popd

# check the number of non-zero vertices/voxels in the ?.atlasroi and Atlas.ROI.? 
mv 3mm_10k 28224_Greyordinates
mv 4mm_2k 8617_Greyordinates


pushd 28224_Greyordinates
wb_command -cifti-create-dense-timeseries 28224_Greyordinates.dtseries.nii -volume Atlas_ROIs.3.nii.gz Atlas_ROIs.3.nii.gz -left-metric L.atlasroi.10k_fs_LR.shape.gii -roi-left L.atlasroi.10k_fs_LR.shape.gii -right-metric R.atlasroi.10k_fs_LR.shape.gii -roi-right R.atlasroi.10k_fs_LR.shape.gii
popd

pushd 8617_Greyordinates
wb_command -cifti-create-dense-timeseries 8617_Greyordinates.dtseries.nii -volume Atlas_ROIs.4.nii.gz Atlas_ROIs.4.nii.gz -left-metric L.atlasroi.2k_fs_LR.shape.gii -roi-left L.atlasroi.2k_fs_LR.shape.gii -right-metric R.atlasroi.2k_fs_LR.shape.gii -roi-right R.atlasroi.2k_fs_LR.shape.gii
popd