-- 家庭记账数据库表结构

-- 创建收支记录表
CREATE TABLE IF NOT EXISTS records (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id TEXT NOT NULL CHECK (user_id IN ('husband', 'wife')),
    date DATE NOT NULL,
    alipay DECIMAL(10,2) DEFAULT 0,
    wechat DECIMAL(10,2) DEFAULT 0,
    cash DECIMAL(10,2) DEFAULT 0,
    expense DECIMAL(10,2) DEFAULT 0,
    remark TEXT DEFAULT '',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- 创建索引以提高查询性能
CREATE INDEX IF NOT EXISTS idx_records_date ON records(date DESC);
CREATE INDEX IF NOT EXISTS idx_records_user ON records(user_id);
CREATE INDEX IF NOT EXISTS idx_records_date_user ON records(date, user_id);

-- 设置 RLS (Row Level Security) 策略，允许匿名用户读写
-- 注意：实际生产环境应该使用身份验证，这里为了简化使用匿名访问
ALTER TABLE records ENABLE ROW LEVEL SECURITY;

-- 允许所有人读取记录
CREATE POLICY "Allow anonymous read" ON records
    FOR SELECT USING (true);

-- 允许所有人插入记录
CREATE POLICY "Allow anonymous insert" ON records
    FOR INSERT WITH CHECK (true);

-- 允许所有人更新自己的记录
CREATE POLICY "Allow anonymous update" ON records
    FOR UPDATE USING (true);

-- 允许所有人删除记录
CREATE POLICY "Allow anonymous delete" ON records
    FOR DELETE USING (true);

-- 插入测试数据（可选）
-- INSERT INTO records (user_id, date, alipay, wechat, cash, expense, remark) 
-- VALUES 
--     ('husband', '2026-03-18', 100, 50, 30, 20, '测试数据');
