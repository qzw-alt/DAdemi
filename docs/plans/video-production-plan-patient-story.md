# 患者故事视频制作方案 - 从素材到成品

> 目标：制作真实感的患者故事视频
> 平台：YouTube（1080p，16:9）
> 时长：3-5分钟

---

## 第一步：获取免费素材

### 推荐网站（无版权，可商用）

| 网站 | 网址 | 特点 |
|------|------|------|
| **Pexels** | https://www.pexels.com | 高质量，免费商用 |
| **Pixabay** | https://pixabay.com | 中文支持，数量多 |
| **Videvo** | https://www.videvo.net | 医疗专业素材多 |
| **Coverr** | https://coverr.co | 免注册直接下载 |

### 搜索关键词

**英文关键词**（Pexels/Pixabay）:
```
hospital patient
doctor consultation
medical examination
patient recovery
happy patient
deep breathing meditation
healthy lifestyle
medical team
hospital corridor
surgical room (blur)
```

**中文关键词**（Pixabay中文）:
```
医院 患者
医生 咨询
体检 健康
康复 恢复
医疗团队
```

### 需要的素材类型

**必备镜头**（每个3-5秒）：
1. ✅ 患者走进医院/挂号
2. ✅ 医生问诊/检查
3. ✅ 手术/治疗过程（模糊处理或背影）
4. ✅ 患者康复/微笑
5. ✅ 医院外观/设施展示
6. ✅ 患者出院/感谢医生

**B-roll素材**：
- 医院走廊走动
- 医疗设备特写
- 窗外风景（表示等待/康复）
- 握手/感谢镜头

---

## 第二步：视频结构

### 患者故事模板（3-5分钟）

```
【00:00-00:15】开场钩子
- 患者正面照片（有感染力）
- 文字："我如何在中国节省了$45,000医疗费"
- 背景音乐起

【00:15-00:45】问题呈现
- 美国高昂的医疗费用（文字+数据）
- 患者的困境（配音讲述）
- 决定寻求海外医疗

【00:45-01:30】中国医疗之旅
- 抵达中国/医院外观
- 初诊过程（医生专业、设备先进）
- 费用对比展示（关键数据）

【01:30-02:30】治疗过程
- 手术/治疗片段（适度过渡）
- 医护关怀细节
- 患者状态好转

【02:30-03:30】康复与感悟
- 康复中的患者
- 费用总结（节省金额醒目显示）
- 患者真实感言（文字引用）

【03:30-04:00】结尾CTA
- 网站链接：chinahospitalsguide.com
- 联系方式
- 订阅频道提示
```

---

## 第三步：制作脚本

### 配音脚本示例

**开场**（15秒）:
"大家好，我是Michael。2025年，我在美国被诊断需要进行膝关节置换手术。猜猜医院报价多少？$50,000。而我最终在中国完成了同样的手术，只花了$8,000。今天我想分享我的真实经历。"

**问题呈现**（30秒）:
"在美国，即使我有保险，自费部分仍然高达$15,000。而且需要等待3个月才能排上手术。我的膝盖疼痛难忍，每天都在煎熬。这时候，我的一位朋友提到了医疗旅游..."

**中国医疗之旅**（45秒）:
"经过研究，我选择了北京的一家三甲医院。从联系他们到安排手术，只用了一周时间。第一次走进医院，我被规模震惊了——这比我在美国见过的任何医院都大，设备也更先进。"

**治疗过程**（60秒）:
"手术进行得非常顺利。最让我惊喜的是医护人员的关怀——每天护士都会来询问我的感受，医生也耐心地解释每一步。病房条件也很好，独立卫生间，还有电视和WiFi。"

**康复与感悟**（60秒）:
"术后两周，我已经可以正常行走。总费用包括手术、住院、翻译服务，一共不到$10,000。我节省了$40,000，而且整个过程比在美国还要顺利。如果早点知道有这个选择就好了。"

**结尾**（30秒）:
"如果你也在考虑海外医疗，希望我的故事能帮到你。访问 chinahospitalsguide.com，获取免费的医院指南。记住，高质量医疗不一定昂贵。感谢观看！"

---

## 第四步：技术规格

### YouTube 最佳实践

| 参数 | 推荐值 |
|------|--------|
| 分辨率 | 1920x1080 (1080p) |
| 帧率 | 30fps |
| 编码 | H.264 |
| 音频 | AAC, 128kbps |
| 时长 | 3-5分钟 |
| 文件格式 | MP4 |

### 字幕要求
- ✅ 必须添加英文字幕（YouTube会推荐）
- ✅ 关键数据用大字显示
- ✅ 患者姓名可用化名

---

## 第五步：制作流程

### 使用 CLI-Anything 自动化

```powershell
# 1. 准备素材目录
$project = "C:\Users\$env:USERNAME\Videos\Patient-Story-Michael"
mkdir "$project\01-Raw-Footage"
mkdir "$project\02-Audio"
mkdir "$project\03-Edited"
mkdir "$project\04-Final"

# 2. 批量转码素材为统一格式
foreach ($video in Get-ChildItem "$project\01-Raw-Footage\*.mp4") {
    ffmpeg -i $video.FullName `
        -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" `
        -c:v libx264 -preset fast -crf 23 `
        -c:a aac -b:a 128k `
        -r 30 `
        "$project\02-Edited\$($video.BaseName)-1080p.mp4"
}

# 3. 添加水印
ffmpeg -i "$project\02-Edited\compiled.mp4" `
    -i "logo.png" `
    -filter_complex "[0:v][1:v]overlay=W-w-20:H-h-20" `
    -c:a copy `
    "$project\04-Final\patient-story-watermarked.mp4"

# 4. 生成缩略图（YouTube封面）
ffmpeg -i "$project\04-Final\patient-story-watermarked.mp4" `
    -ss 00:00:05 `
    -vframes 1 `
    -vf "scale=1280:720" `
    "$project\04-Final\thumbnail-youtube.jpg"
```

---

## 第六步：发布清单

### YouTube 上传前检查

- [ ] 视频时长 3-5分钟
- [ ] 分辨率 1080p
- [ ] 添加了字幕文件 (.srt)
- [ ] 封面图 1280x720
- [ ] 标题含关键词（Medical Tourism China, Patient Story）
- [ ] 描述包含网站链接
- [ ] 标签添加（medical tourism, China healthcare, patient story）
- [ ] 隐私设置：公开

### 推荐标题格式
```
"How I Saved $40,000 on Knee Surgery in China | Medical Tourism Patient Story"
"美国$50,000手术 vs 中国$8,000 | 我的真实医疗旅游经历"
"From Pain to Recovery: My Journey to a Chinese Hospital"
```

### 推荐描述模板
```
In this video, I share my real experience of getting knee replacement surgery in China and how I saved over $40,000 compared to US prices.

⏱️ TIMESTAMPS:
0:00 - My situation in the US
0:45 - Deciding to go to China
1:30 - Arriving at the hospital
2:30 - Surgery and recovery
3:30 - Cost breakdown

💰 COST COMPARISON:
US Hospital Quote: $50,000
China Total Cost: $8,000
Total Savings: $42,000

🏥 HOSPITAL:
Beijing [Hospital Name]
https://chinahospitalsguide.com

📧 CONTACT:
contact@chinahospitalsguide.com

#MedicalTourism #ChinaHealthcare #PatientStory #Savings
```

---

## 下一步行动

### 需要你做的：
1. **访问 Pexels/Pixabay**，搜索上述关键词
2. **下载 10-15个相关视频片段**
3. **将素材放到** `C:\Users\你的用户名\Videos\Patient-Story-Michael\01-Raw-Footage\`

### 然后我来做：
1. 自动转码所有素材为统一格式
2. 按脚本顺序拼接视频
3. 添加文字说明和水印
4. 生成YouTube封面缩略图
5. 输出最终成品

---

准备好了吗？先下载素材，然后告诉我素材位置！
