import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database';
import Event from './Event';

interface MoyEntryAttributes {
  id: number;
  event_id: number;
  contributor_name: string;
  amount: number;
  notes?: string;
  place?: string;
  created_at?: Date;
  updated_at?: Date;
}

interface MoyEntryCreationAttributes extends Omit<MoyEntryAttributes, 'id'> {}

class MoyEntry extends Model<MoyEntryAttributes, MoyEntryCreationAttributes> implements MoyEntryAttributes {
  public id!: number;
  public event_id!: number;
  public contributor_name!: string;
  public amount!: number;
  public notes!: string;
  public place!: string;
  public readonly created_at!: Date;
  public readonly updated_at!: Date;
}

MoyEntry.init(
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
    contributor_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    amount: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
    },
    notes: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    place: {
      type: DataTypes.STRING,
      allowNull: true,
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
    modelName: 'MoyEntry',
    tableName: 'MoyEntries',
    timestamps: false,
  }
);

export default MoyEntry;