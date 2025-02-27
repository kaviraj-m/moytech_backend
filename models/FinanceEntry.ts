import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database';
import Event from './Event';

interface FinanceEntryAttributes {
  id: number;
  event_id: number;
  type: 'INCOME' | 'EXPENSE';
  amount: number;
  description: string;
  date: Date;
  category: string;
  created_at?: Date;
  updated_at?: Date;
}

interface FinanceEntryCreationAttributes extends Omit<FinanceEntryAttributes, 'id'> {}

class FinanceEntry extends Model<FinanceEntryAttributes, FinanceEntryCreationAttributes> implements FinanceEntryAttributes {
  public id!: number;
  public event_id!: number;
  public type!: 'INCOME' | 'EXPENSE';
  public amount!: number;
  public description!: string;
  public date!: Date;
  public category!: string;
  public readonly created_at!: Date;
  public readonly updated_at!: Date;
}

FinanceEntry.init(
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    event_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: Event,
        key: 'id',
      },
    },
    type: {
      type: DataTypes.ENUM('INCOME', 'EXPENSE'),
      allowNull: false,
    },
    amount: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
    },
    description: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    date: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    category: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
      field: 'created_at',
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
      field: 'updated_at',
    },
  },
  {
    sequelize,
    modelName: 'FinanceEntry',
    tableName: 'FinanceEntries',
    timestamps: false,
  }
);

export default FinanceEntry;