# README

網站UI設計 : [設計稿](https://www.figma.com/file/SLk4Gxyol4VHLQvHoLlxl4/TodoApp_design?node-id=0%3A1 "figma")

資料庫規劃 : [table規劃](https://www.figma.com/file/SLk4Gxyol4VHLQvHoLlxl4/TodoApp_design?node-id=7%3A162 "figma")

## Table Schema

### User
| 欄位 | 型態 | 說明 |
| ---- | ---- | ---- |
| id | Integer | 流水號 |
| name | String | 用戶名 |
| password | String | 密碼 |
| role | String | 用戶角色 |

### Task
| 欄位 | 型態 | 說明 |
| ---- | ---- | ---- |
| id | Integer | 流水號 |
| title | String | 任務標題 |
| content | String | 任務內容 |
| startTime | Date | 開始時間 |
| endTime | Date | 結束時間 |
| status | Integer | 狀態 |
| priority | Integer | 優先 |
| user_id | Integer | 用戶編號 |

### Tag 
| 欄位 | 型態 | 說明 |
| ---- | ---- | ---- |
| id | Integer | 流水號 |
| name | String | 標籤名 |
| task_id | Integer | 任務編號 |

### Classifier
| 欄位 | 型態 | 說明 |
| ---- | ---- | ---- |
| id | Integer | 流水號 |
| tag_id | Integer | 標籤編號 |
| task_id | Integer | 任務編號 |
